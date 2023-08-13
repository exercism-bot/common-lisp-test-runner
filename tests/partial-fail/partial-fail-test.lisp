;; Ensures that partial-fail.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "partial-fail")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from leap and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :partial-fail-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :partial-fail-test)

;; Define and enter a new FiveAM test-suite
(def-suite* leap-suite)

(test vanilla-leap-year (is (partial-fail:leap-year-p 1996)))

(test any-old-year (is (not (partial-fail:leap-year-p 1997))))

(test non-leap-even-year (is (not (partial-fail:leap-year-p 1998))))

(test century (is (not (partial-fail:leap-year-p 1900))))

(test exceptional-century (is (partial-fail:leap-year-p 2400)))

(defun run-tests (&optional (test-or-suite 'leap-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
