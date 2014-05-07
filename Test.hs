import Diagrams.Prelude
import Diagrams.Backend.SVG
import Data.Default
import Graphics.Rendering.HPlot
import System.Random
import Data.List.Split
import Control.Lens ((^.))

xs :: [Double]
xs = take 2000 $ randomRs (-100, 100) $ mkStdGen 2

xs' :: [[Double]]
xs' = chunksOf 50 xs

main = do
    let xaxis = indexAxis 50 [] 0.056 $ with & tickLen .~ (-0.05)
        yaxis = indexAxis 40 [] 0.056 $ with & tickLen .~ (-0.05)
        area = plotArea 5.5 4.8 (yaxis, emptyAxis, emptyAxis, xaxis)
        heat = heatmap xs' def
        legend = colorKey 0.3 4.8 (minimum xs, maximum xs) (def^.palette)
        p = area <+ (heat, BL)
    renderSVG "1.svg" (Dims 480 480) $ (center $ showPlot p) ||| strutX 0.2 ||| center legend
