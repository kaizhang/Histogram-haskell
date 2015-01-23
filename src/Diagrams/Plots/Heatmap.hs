{-# LANGUAGE TemplateHaskell #-}

module Diagrams.Plots.Heatmap
    ( heatmap
    , colorKey
    , palette
    ) where

import Diagrams.Prelude
import Data.Default
import Control.Lens hiding ((#))
import Data.Maybe
import Data.Colour.Palette.BrewerSet

import Diagrams.Plots.Types
import Diagrams.Plots.Utils

data HeatmapOpts = HeatmapOpts
    { _palette :: [Colour Double] 
    }

instance Default HeatmapOpts where
    def = HeatmapOpts
        { _palette = reverse $ brewerSet RdYlBu 11
        }

makeLenses ''HeatmapOpts

heatmap :: [[Double]] -> HeatmapOpts -> PlotFn
heatmap mat opt mapX mapY = map (\(Just (x,y), z) -> rect' z # moveTo (x ^& y)) ps
  where
    nRows = fromIntegral.length $ mat
    nCols = fromIntegral.length.head $ mat
    rect' z = rect gapX gapY # lwL 0 # fc (colorMap z (opt^.palette))
    ps = filter (isJust.fst) $ mapped._1 %~ runMap pMap $ zip [(x, y) | y <- [nRows, nRows-1..1], x <- [1..nCols]] mat''
    mat'' = map f mat'
    f = fromJust.runMap (linearMap r (0,1))
    r = (minimum mat', maximum mat')
    mat' = concat mat
    gapX = (fromJust.runMap mapX) 2 - (fromJust.runMap mapX) 1
    gapY = (fromJust.runMap mapY) 2 - (fromJust.runMap mapY) 1
    pMap = compose mapX mapY

colorKey :: Double -> Double -> (Double, Double) -> [Colour Double] -> DiaR2
colorKey w h r cs = vcat (map rect' [1,0.995..0])
  where
    rect' z = rect w (h/200) # lc (colorMap z cs) # fc (colorMap z cs)

colorMap :: Double -- a value from 0 to 1
         -> [Colour Double] -> Colour Double
{-# INLINE colorMap #-}
colorMap x colors = blend p c1 c2
  where
    c1 = colors !! (i-1)
    c2 = colors !! i
    p =  fromIntegral i - x * (n - 1)
    i = 1 + truncate (x * (n - 2))
    n = fromIntegral.length $ colors