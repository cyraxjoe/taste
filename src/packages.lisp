(defpackage :taste
  (:use :cl :prove)
  (:shadow :describe :the)
  (:export :file :should))

(defpackage :taste-file
  (:use :cl)
  (:export  :file
            :file-path
            :make-file
            :should
            :exists))

