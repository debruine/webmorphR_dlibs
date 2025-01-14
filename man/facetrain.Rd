% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/facetrain.R
\name{facetrain}
\alias{facetrain}
\title{Train a dlib shape predictor}
\usage{
facetrain(
  xml,
  output = "shape_predictor.dat",
  tree_depth = 5L,
  nu = 0.5,
  cascade_depth = 15L,
  feature_pool_size = 400L,
  num_test_splits = 50L,
  oversampling_amount = 5L,
  jitter = 0.1,
  num_threads = 0L
)
}
\arguments{
\item{xml}{The xml file containing the bounding boxes and training points, usually created by \link{tem_to_xml}}

\item{output}{the name of the .dat file to save the model to}

\item{tree_depth}{the depth of each regression tree; typically 2:8}

\item{nu}{regularization parameter; must be 0:1}

\item{cascade_depth}{the number of cascades used to train the shape predictor; typically 6:18}

\item{feature_pool_size}{number of pixels used to generate features for the random trees at each cascade}

\item{num_test_splits}{selects best features at each cascade when training}

\item{oversampling_amount}{controls the number of random deformations per image (i.e., data augmentation) when training the shape predictor; typically 0:50}

\item{jitter}{amount of oversampling translation jitter to apply; typically 0 to 0.5}

\item{num_threads}{number of threads/CPU cores to be used when training}
}
\value{
the path to the output file (invisibly)
}
\description{
Implements a python script from PyImageSearch to train a custom shape predictor model using dlib and OpenCV. Produces a shape predictor file from an xml file containing the image paths, bounding boxes and training points, usually created by \code{\link[=tem_to_xml]{tem_to_xml()}}.

Adrian Rosebrock, Training a custom dlib shape predictor, PyImageSearch, https://www.pyimagesearch.com/2019/12/16/training-a-custom-dlib-shape-predictor/, accessed on 13 May 2022
}
\details{
NB: The python script will cause R to crash if you try to fit a model with fewer than 8 training faces.

This text is from Adrian Rosebrock's explanation:
\itemize{
\item tree_depth: the depth of each regression tree -- typical values are between 2 and 8; there will be a total of 2^tree_depth leaves in each tree; small values of tree_depth will be \emph{faster} but \emph{less accurate} while larger values will generate trees that are \emph{deeper}, \emph{more accurate}, but will run \emph{far slower} when making predictions
\item nu: a regularization parameter in the range 0:1 that is used to help our model generalize -- values closer to 1 will make our model fit the training data better, but could cause overfitting; values closer to 0 will help our model generalize but will require us to have training data in the order of 1000s of data points
\item cascade_depth: the number of cascades used to train the shape predictor -- typical values are between 6 and 18; this parameter has a \emph{dramatic} impact on both the \emph{accuracy} and \emph{output size} of your model; the more cascades you have, the more accurate your model can potentially be, but also the \emph{larger} the output size
\item feature_pool_size: number of pixels used to generate features for the random trees at each cascade -- larger pixel values will make your shape predictor more accurate, but slower; use large values if speed is not a problem, otherwise smaller values for resource constrained/embedded devices
\item num_test_splits: selects best features at each cascade when training -- the larger this value is, the \emph{longer} it will take to train but (potentially) the more \emph{accurate} your model will be
\item oversampling_amount: controls the number of random deformations per image (i.e., data augmentation) when training the shape predictor -- applies the supplied number of random deformations, thereby performing regularization and increasing the ability of our model to generalize
\item oversampling_translation_jitter: amount of translation jitter to apply -- the dlib docs recommend values in the range 0 to 0.5
\item num_threads: number of threads/CPU cores to be used when training -- defaults to the number of available cores on the system, but you can supply an integer value
}
}
\examples{
\dontrun{
  # requires python and dlib
  xml <- system.file("demo/_images.xml", package = "webmorphR.dlib")

  # train model
  newmodel <- facetrain(xml)

  # check model on new images
  newdelin <- webmorphR.stim::load_stim_zoom() |>
    auto_delin(replace = TRUE, dat_file = newmodel)

  newdelin |> draw_tem() |> plot(nrow = 6)
}
}
