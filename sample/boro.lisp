(require :taste)
(in-package :taste)


(the file "/tmp/test.txt" 
     (should exists)
     (should be-regular-file))

(the file "/tmp/tes" 
     (should-not exists))

(the file "/tmp/slink" 
     (should  be-symlink))


