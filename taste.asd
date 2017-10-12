(defsystem "taste"
  :description "taste: Infrastructure test runner."
  :version "0.0.1"
  :author "Joel Rivera <rivera@joel.mx>"
  :licence "MIT"
  :depends-on (:unix-options :prove :cl-ppcre)
  :components ((:file "src/packages")
               (:file "src/taste" :depends-on ("src/packages"))
               (:file "src/file" :depends-on ("src/packages"))))
