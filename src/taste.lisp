(in-package :taste)

(defmacro describe (func params should_action)
  "Connect the high level DSL into the appropiate tests on the
   system resources"
  (let  ((should-func (car should_action))
         (action (string (cadr should_action))))
    
    `(let ((inst (,func ,params))
           (reason
            (cl-ppcre:regex-replace-all "-" (symbol-name (quote ,should-func)) " "))
           (pretty-action
            (cl-ppcre:regex-replace-all "-" ,action " a ")))
       (ok (,should-func inst  ,action)
           (description inst pretty-action  reason)))))
  
(defmacro context (&body args)
  "Alternative name to 'describe'"
  `(describe ,@args))

(defmacro the (func &body args)
  "Alternative name to 'describe'"
  `(describe ,func ,@args))

(defmacro should-not (&body args)
  "Simple macro to invert the result of should and have a more
   expressive test when we want to expres negation at a high-level."
  `(not (should ,@args)))

(defun file (path)
  "Construct a new file resource on which we can operate"
  (taste-file:make-file path))








