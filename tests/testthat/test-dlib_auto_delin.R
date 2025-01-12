test_that("dlib_auto_delin", {
  stimuli <- demo_stim("f")
  expect_error(dlib_auto_delin())
  # all images have templates
  expect_warning(x <- dlib_auto_delin(stimuli))
  expect_equal(x, stimuli)

  expect_error( auto_delin(x, "dd") )
})

test_that("python", {
  skip_on_cran()

  stimuli <- demo_stim("f_")

  s7 <- dlib_auto_delin(stimuli, "dlib7", TRUE)
  expect_equal(s7[[1]]$points |> dim(), c(2, 7))

  custom <- system.file("python/shape_predictor_5_face_landmarks.dat", package = "webmorphR.dlib")
  s5 <- dlib_auto_delin(stimuli, replace = TRUE, model_path = custom)
  expect_equivalent(s7[[1]]$points[, 3:7],
                    s5[[1]]$points)

  s70 <- dlib_auto_delin(stimuli, "dlib70", TRUE)
  expect_equal(s70[[1]]$points |> dim(), c(2, 70))

  # draw_tem(s7)
  # draw_tem(s5)
  # draw_tem(s70)
})

