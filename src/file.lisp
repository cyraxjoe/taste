(in-package :taste-file)

(defclass file ()
  ((path :accessor file-path
         :initarg :path)))

(defun cmd-exit-code (cmd &rest params)
  (let ((result (sb-ext:run-program cmd  params
                                    :output nil
                                    :search t
                                    :if-error-exists nil)))
     (sb-ext:process-exit-code result)))

(defmacro -test (flag self)
  `(cmd-exit-code "test" ,flag (file-path ,self)))


;; actions
(defmethod exists ((self file))
  "Return T if  the file exists, otherwise nil."
  (equal (cmd-exit-code "test"  "-e" (file-path self)) 0))

(defmethod be-regular-file ((self file))
  "Return T if the path of the file correspond to a regular file"
  (equal (-test "-e" self) 0))

(defmethod be-symlink ((self file))
  "Return T if the path of the file correspond to a symlink"
  (equal (-test "-L" self) 0))

;;

(defun make-file (path)
  "Convenient function to create a new file instance."
  (make-instance 'file :path path))

(in-package :taste)

(defmethod should ((self taste-file:file) (action string) &rest params)
  "Main handler of the actions for the file type."
  (in-package :taste-file)
  (let* ((method (symbol-function (intern (string-upcase action))))
         (rvalue (apply method (append (list self) params))))
        (in-package :taste)
        rvalue))

(defmethod description ((self taste-file:file) (action string) (reason string) &rest params)
  (format nil "The file '~A' ~(~a~) ~(~a~)"
          (taste-file:file-path self) reason action))
