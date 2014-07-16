{-# LANGUAGE TemplateHaskell #-}

module Graphics.Rendering.HPlot.Plots.Line 
    ( line
    , LineOpts
    , lineshape
    ) where

import Diagrams.Prelude
import Data.Default
import Control.Lens (makeLenses, (^.))
import Data.Maybe
import Graphics.Rendering.HPlot.Types
import Graphics.Rendering.HPlot.Utils (hasNaN)

data LineOpts = LineOpts
    { _lineshape :: Char
    }

makeLenses ''LineOpts

instance Default LineOpts where
    def = LineOpts
        { _lineshape = 'o'
        }

line :: (PlotData m1 a1, PlotData m2 a2) => m1 a1 -> m2 a2 -> LineOpts -> DelayPlot
line xs ys opt (mapX, mapY) | hasNaN xy = error "Line: Found NaN"
                            | otherwise = [l]
  where
    l = lwO 1 $ fromVertices.map p2.mapMaybe (runMap pMap) $ xy
    xy = zip (getValues xs) $ getValues ys
    pMap = compose (mapX, mapY)
