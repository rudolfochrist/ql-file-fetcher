(unless (find-package :quicklisp)
  (error "Cannot register file fetcher if quicklisp is not loaded."))

(defmethod initialize-instance :after ((url ql-http:url) &key)
  (when (string= (ql-http:scheme url) "file")
    (setf (ql-http:hostname url) "")))

(push (cons "file" 'ql-file-fetcher:fetch-file) ql-http:*fetch-scheme-functions*)
