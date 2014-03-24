{-# LANGUAGE OverloadedStrings, UnicodeSyntax #-}

module Graphics.Rendering.HPlot.DataSet where

sample ∷ [Double]
sample = [69.9, 69.0, 69.6, 68.5, 65.0, 65.9, 67.2, 67.5, 68.0, 68.6, 68.9, 70.0, 69.5, 70.4, 71.1, 71.0, 72.5, 73.1, 68.8, 71.3,
    68.2, 68.5, 70.0, 66.8, 69.0, 69.3, 69.1, 69.4, 68.5, 65.5, 66.0, 66.5, 67.5, 68.3, 68.2, 69.1, 70.2, 69.5, 70.5, 70.8, 71.0, 72.5, 73.0,
    69.0, 71.3, 68.2, 68.5, 70.0, 67.0, 69.2]

sample2 ∷ [Double]
sample2 = [0.1, 0.2, 0.3, 0.4, 0.1, 0.12, 0.35, 0.55, 0.44, 0.6, 0.23, 0.24, 0.3]

flower ∷ ([Double],[Double])
flower = unzip [ (r a * sin (a*dr),r a * cos (a*dr)) | a ← [0,0.5..360∷Double] ]
    where
        dr = 2 * pi / 360
        r a = 0.8 * cos (a * 20 * pi /360)
