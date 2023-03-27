;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((((http[s]?|ftp)[:]//)([a-zA-Z0-9.-]+([:][a-zA-Z0-9.&amp;%$-]+)*@)?[a-zA-Z][a-zA-Z0-9.-]+|[a-zA-Z][a-zA-Z0-9]+[.][a-zA-Z][a-zA-Z0-9.-]+)[.](com|edu|gov|mil|net|org|biz|pro|info|name|museum|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|az|ax|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cs|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|ee|eg|eh|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|mg|mh|mk|ml|mm|mn|mo|mp|mq|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ro|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw)([:][0-9]+)*(/[a-zA-Z0-9.,;?'\\+&amp;%$#=~_-]+)*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "=JC.TtZ.edu/4"
(define-fun Witness1 () String (str.++ "=" (str.++ "J" (str.++ "C" (str.++ "." (str.++ "T" (str.++ "t" (str.++ "Z" (str.++ "." (str.++ "e" (str.++ "d" (str.++ "u" (str.++ "/" (str.++ "4" ""))))))))))))))
;witness2: "RM82f1.nT.nr\u00E5\u00BA"
(define-fun Witness2 () String (str.++ "R" (str.++ "M" (str.++ "8" (str.++ "2" (str.++ "f" (str.++ "1" (str.++ "." (str.++ "n" (str.++ "T" (str.++ "." (str.++ "n" (str.++ "r" (str.++ "\u{e5}" (str.++ "\u{ba}" "")))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.++ (re.union (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" ""))))) (re.opt (re.range "s" "s"))) (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" ""))))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range ":" ":") (re.+ (re.union (re.range "$" "&")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))) (re.range "@" "@"))))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))) (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "m" ""))))(re.union (str.to_re (str.++ "e" (str.++ "d" (str.++ "u" ""))))(re.union (str.to_re (str.++ "g" (str.++ "o" (str.++ "v" ""))))(re.union (str.to_re (str.++ "m" (str.++ "i" (str.++ "l" ""))))(re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "t" ""))))(re.union (str.to_re (str.++ "o" (str.++ "r" (str.++ "g" ""))))(re.union (str.to_re (str.++ "b" (str.++ "i" (str.++ "z" ""))))(re.union (str.to_re (str.++ "p" (str.++ "r" (str.++ "o" ""))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))(re.union (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" "")))))(re.union (str.to_re (str.++ "m" (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "u" (str.++ "m" "")))))))(re.union (str.to_re (str.++ "a" (str.++ "c" "")))(re.union (str.to_re (str.++ "a" (str.++ "d" "")))(re.union (str.to_re (str.++ "a" (str.++ "e" "")))(re.union (str.to_re (str.++ "a" (str.++ "f" "")))(re.union (str.to_re (str.++ "a" (str.++ "g" "")))(re.union (str.to_re (str.++ "a" (str.++ "i" "")))(re.union (str.to_re (str.++ "a" (str.++ "l" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "a" (str.++ "n" "")))(re.union (str.to_re (str.++ "a" (str.++ "o" "")))(re.union (str.to_re (str.++ "a" (str.++ "q" "")))(re.union (str.to_re (str.++ "a" (str.++ "r" "")))(re.union (str.to_re (str.++ "a" (str.++ "s" "")))(re.union (str.to_re (str.++ "a" (str.++ "t" "")))(re.union (str.to_re (str.++ "a" (str.++ "u" "")))(re.union (str.to_re (str.++ "a" (str.++ "w" "")))(re.union (str.to_re (str.++ "a" (str.++ "z" "")))(re.union (str.to_re (str.++ "a" (str.++ "x" "")))(re.union (str.to_re (str.++ "b" (str.++ "a" "")))(re.union (str.to_re (str.++ "b" (str.++ "b" "")))(re.union (str.to_re (str.++ "b" (str.++ "d" "")))(re.union (str.to_re (str.++ "b" (str.++ "e" "")))(re.union (str.to_re (str.++ "b" (str.++ "f" "")))(re.union (str.to_re (str.++ "b" (str.++ "g" "")))(re.union (str.to_re (str.++ "b" (str.++ "h" "")))(re.union (str.to_re (str.++ "b" (str.++ "i" "")))(re.union (str.to_re (str.++ "b" (str.++ "j" "")))(re.union (str.to_re (str.++ "b" (str.++ "m" "")))(re.union (str.to_re (str.++ "b" (str.++ "n" "")))(re.union (str.to_re (str.++ "b" (str.++ "o" "")))(re.union (str.to_re (str.++ "b" (str.++ "r" "")))(re.union (str.to_re (str.++ "b" (str.++ "s" "")))(re.union (str.to_re (str.++ "b" (str.++ "t" "")))(re.union (str.to_re (str.++ "b" (str.++ "v" "")))(re.union (str.to_re (str.++ "b" (str.++ "w" "")))(re.union (str.to_re (str.++ "b" (str.++ "y" "")))(re.union (str.to_re (str.++ "b" (str.++ "z" "")))(re.union (str.to_re (str.++ "c" (str.++ "a" "")))(re.union (str.to_re (str.++ "c" (str.++ "c" "")))(re.union (str.to_re (str.++ "c" (str.++ "d" "")))(re.union (str.to_re (str.++ "c" (str.++ "f" "")))(re.union (str.to_re (str.++ "c" (str.++ "g" "")))(re.union (str.to_re (str.++ "c" (str.++ "h" "")))(re.union (str.to_re (str.++ "c" (str.++ "i" "")))(re.union (str.to_re (str.++ "c" (str.++ "k" "")))(re.union (str.to_re (str.++ "c" (str.++ "l" "")))(re.union (str.to_re (str.++ "c" (str.++ "m" "")))(re.union (str.to_re (str.++ "c" (str.++ "n" "")))(re.union (str.to_re (str.++ "c" (str.++ "o" "")))(re.union (str.to_re (str.++ "c" (str.++ "r" "")))(re.union (str.to_re (str.++ "c" (str.++ "s" "")))(re.union (str.to_re (str.++ "c" (str.++ "u" "")))(re.union (str.to_re (str.++ "c" (str.++ "v" "")))(re.union (str.to_re (str.++ "c" (str.++ "x" "")))(re.union (str.to_re (str.++ "c" (str.++ "y" "")))(re.union (str.to_re (str.++ "c" (str.++ "z" "")))(re.union (str.to_re (str.++ "d" (str.++ "e" "")))(re.union (str.to_re (str.++ "d" (str.++ "j" "")))(re.union (str.to_re (str.++ "d" (str.++ "k" "")))(re.union (str.to_re (str.++ "d" (str.++ "m" "")))(re.union (str.to_re (str.++ "d" (str.++ "o" "")))(re.union (str.to_re (str.++ "d" (str.++ "z" "")))(re.union (str.to_re (str.++ "e" (str.++ "c" "")))(re.union (str.to_re (str.++ "e" (str.++ "e" "")))(re.union (str.to_re (str.++ "e" (str.++ "g" "")))(re.union (str.to_re (str.++ "e" (str.++ "h" "")))(re.union (str.to_re (str.++ "e" (str.++ "r" "")))(re.union (str.to_re (str.++ "e" (str.++ "s" "")))(re.union (str.to_re (str.++ "e" (str.++ "t" "")))(re.union (str.to_re (str.++ "e" (str.++ "u" "")))(re.union (str.to_re (str.++ "f" (str.++ "i" "")))(re.union (str.to_re (str.++ "f" (str.++ "j" "")))(re.union (str.to_re (str.++ "f" (str.++ "k" "")))(re.union (str.to_re (str.++ "f" (str.++ "m" "")))(re.union (str.to_re (str.++ "f" (str.++ "o" "")))(re.union (str.to_re (str.++ "f" (str.++ "r" "")))(re.union (str.to_re (str.++ "g" (str.++ "a" "")))(re.union (str.to_re (str.++ "g" (str.++ "b" "")))(re.union (str.to_re (str.++ "g" (str.++ "d" "")))(re.union (str.to_re (str.++ "g" (str.++ "e" "")))(re.union (str.to_re (str.++ "g" (str.++ "f" "")))(re.union (str.to_re (str.++ "g" (str.++ "g" "")))(re.union (str.to_re (str.++ "g" (str.++ "h" "")))(re.union (str.to_re (str.++ "g" (str.++ "i" "")))(re.union (str.to_re (str.++ "g" (str.++ "l" "")))(re.union (str.to_re (str.++ "g" (str.++ "m" "")))(re.union (str.to_re (str.++ "g" (str.++ "n" "")))(re.union (str.to_re (str.++ "g" (str.++ "p" "")))(re.union (str.to_re (str.++ "g" (str.++ "q" "")))(re.union (str.to_re (str.++ "g" (str.++ "r" "")))(re.union (str.to_re (str.++ "g" (str.++ "s" "")))(re.union (str.to_re (str.++ "g" (str.++ "t" "")))(re.union (str.to_re (str.++ "g" (str.++ "u" "")))(re.union (str.to_re (str.++ "g" (str.++ "w" "")))(re.union (str.to_re (str.++ "h" (str.++ "k" "")))(re.union (str.to_re (str.++ "h" (str.++ "m" "")))(re.union (str.to_re (str.++ "h" (str.++ "n" "")))(re.union (str.to_re (str.++ "h" (str.++ "r" "")))(re.union (str.to_re (str.++ "h" (str.++ "t" "")))(re.union (str.to_re (str.++ "h" (str.++ "u" "")))(re.union (str.to_re (str.++ "i" (str.++ "d" "")))(re.union (str.to_re (str.++ "i" (str.++ "e" "")))(re.union (str.to_re (str.++ "i" (str.++ "l" "")))(re.union (str.to_re (str.++ "i" (str.++ "m" "")))(re.union (str.to_re (str.++ "i" (str.++ "n" "")))(re.union (str.to_re (str.++ "i" (str.++ "o" "")))(re.union (str.to_re (str.++ "i" (str.++ "q" "")))(re.union (str.to_re (str.++ "i" (str.++ "r" "")))(re.union (str.to_re (str.++ "i" (str.++ "s" "")))(re.union (str.to_re (str.++ "i" (str.++ "t" "")))(re.union (str.to_re (str.++ "j" (str.++ "e" "")))(re.union (str.to_re (str.++ "j" (str.++ "m" "")))(re.union (str.to_re (str.++ "j" (str.++ "o" "")))(re.union (str.to_re (str.++ "j" (str.++ "p" "")))(re.union (str.to_re (str.++ "k" (str.++ "e" "")))(re.union (str.to_re (str.++ "k" (str.++ "g" "")))(re.union (str.to_re (str.++ "k" (str.++ "h" "")))(re.union (str.to_re (str.++ "k" (str.++ "i" "")))(re.union (str.to_re (str.++ "k" (str.++ "m" "")))(re.union (str.to_re (str.++ "k" (str.++ "n" "")))(re.union (str.to_re (str.++ "k" (str.++ "p" "")))(re.union (str.to_re (str.++ "k" (str.++ "r" "")))(re.union (str.to_re (str.++ "k" (str.++ "w" "")))(re.union (str.to_re (str.++ "k" (str.++ "y" "")))(re.union (str.to_re (str.++ "k" (str.++ "z" "")))(re.union (str.to_re (str.++ "l" (str.++ "a" "")))(re.union (str.to_re (str.++ "l" (str.++ "b" "")))(re.union (str.to_re (str.++ "l" (str.++ "c" "")))(re.union (str.to_re (str.++ "l" (str.++ "i" "")))(re.union (str.to_re (str.++ "l" (str.++ "k" "")))(re.union (str.to_re (str.++ "l" (str.++ "r" "")))(re.union (str.to_re (str.++ "l" (str.++ "s" "")))(re.union (str.to_re (str.++ "l" (str.++ "t" "")))(re.union (str.to_re (str.++ "l" (str.++ "u" "")))(re.union (str.to_re (str.++ "l" (str.++ "v" "")))(re.union (str.to_re (str.++ "l" (str.++ "y" "")))(re.union (str.to_re (str.++ "m" (str.++ "a" "")))(re.union (str.to_re (str.++ "m" (str.++ "c" "")))(re.union (str.to_re (str.++ "m" (str.++ "d" "")))(re.union (str.to_re (str.++ "m" (str.++ "g" "")))(re.union (str.to_re (str.++ "m" (str.++ "h" "")))(re.union (str.to_re (str.++ "m" (str.++ "k" "")))(re.union (str.to_re (str.++ "m" (str.++ "l" "")))(re.union (str.to_re (str.++ "m" (str.++ "m" "")))(re.union (str.to_re (str.++ "m" (str.++ "n" "")))(re.union (str.to_re (str.++ "m" (str.++ "o" "")))(re.union (str.to_re (str.++ "m" (str.++ "p" "")))(re.union (str.to_re (str.++ "m" (str.++ "q" "")))(re.union (str.to_re (str.++ "m" (str.++ "r" "")))(re.union (str.to_re (str.++ "m" (str.++ "s" "")))(re.union (str.to_re (str.++ "m" (str.++ "t" "")))(re.union (str.to_re (str.++ "m" (str.++ "u" "")))(re.union (str.to_re (str.++ "m" (str.++ "v" "")))(re.union (str.to_re (str.++ "m" (str.++ "w" "")))(re.union (str.to_re (str.++ "m" (str.++ "x" "")))(re.union (str.to_re (str.++ "m" (str.++ "y" "")))(re.union (str.to_re (str.++ "m" (str.++ "z" "")))(re.union (str.to_re (str.++ "n" (str.++ "a" "")))(re.union (str.to_re (str.++ "n" (str.++ "c" "")))(re.union (str.to_re (str.++ "n" (str.++ "e" "")))(re.union (str.to_re (str.++ "n" (str.++ "f" "")))(re.union (str.to_re (str.++ "n" (str.++ "g" "")))(re.union (str.to_re (str.++ "n" (str.++ "i" "")))(re.union (str.to_re (str.++ "n" (str.++ "l" "")))(re.union (str.to_re (str.++ "n" (str.++ "o" "")))(re.union (str.to_re (str.++ "n" (str.++ "p" "")))(re.union (str.to_re (str.++ "n" (str.++ "r" "")))(re.union (str.to_re (str.++ "n" (str.++ "u" "")))(re.union (str.to_re (str.++ "n" (str.++ "z" "")))(re.union (str.to_re (str.++ "o" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "a" "")))(re.union (str.to_re (str.++ "p" (str.++ "e" "")))(re.union (str.to_re (str.++ "p" (str.++ "f" "")))(re.union (str.to_re (str.++ "p" (str.++ "g" "")))(re.union (str.to_re (str.++ "p" (str.++ "h" "")))(re.union (str.to_re (str.++ "p" (str.++ "k" "")))(re.union (str.to_re (str.++ "p" (str.++ "l" "")))(re.union (str.to_re (str.++ "p" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "n" "")))(re.union (str.to_re (str.++ "p" (str.++ "r" "")))(re.union (str.to_re (str.++ "p" (str.++ "s" "")))(re.union (str.to_re (str.++ "p" (str.++ "t" "")))(re.union (str.to_re (str.++ "p" (str.++ "w" "")))(re.union (str.to_re (str.++ "p" (str.++ "y" "")))(re.union (str.to_re (str.++ "q" (str.++ "a" "")))(re.union (str.to_re (str.++ "r" (str.++ "e" "")))(re.union (str.to_re (str.++ "r" (str.++ "o" "")))(re.union (str.to_re (str.++ "r" (str.++ "u" "")))(re.union (str.to_re (str.++ "r" (str.++ "w" "")))(re.union (str.to_re (str.++ "s" (str.++ "a" "")))(re.union (str.to_re (str.++ "s" (str.++ "b" "")))(re.union (str.to_re (str.++ "s" (str.++ "c" "")))(re.union (str.to_re (str.++ "s" (str.++ "d" "")))(re.union (str.to_re (str.++ "s" (str.++ "e" "")))(re.union (str.to_re (str.++ "s" (str.++ "g" "")))(re.union (str.to_re (str.++ "s" (str.++ "h" "")))(re.union (str.to_re (str.++ "s" (str.++ "i" "")))(re.union (str.to_re (str.++ "s" (str.++ "j" "")))(re.union (str.to_re (str.++ "s" (str.++ "k" "")))(re.union (str.to_re (str.++ "s" (str.++ "l" "")))(re.union (str.to_re (str.++ "s" (str.++ "m" "")))(re.union (str.to_re (str.++ "s" (str.++ "n" "")))(re.union (str.to_re (str.++ "s" (str.++ "o" "")))(re.union (str.to_re (str.++ "s" (str.++ "r" "")))(re.union (str.to_re (str.++ "s" (str.++ "t" "")))(re.union (str.to_re (str.++ "s" (str.++ "v" "")))(re.union (str.to_re (str.++ "s" (str.++ "y" "")))(re.union (str.to_re (str.++ "s" (str.++ "z" "")))(re.union (str.to_re (str.++ "t" (str.++ "c" "")))(re.union (str.to_re (str.++ "t" (str.++ "d" "")))(re.union (str.to_re (str.++ "t" (str.++ "f" "")))(re.union (str.to_re (str.++ "t" (str.++ "g" "")))(re.union (str.to_re (str.++ "t" (str.++ "h" "")))(re.union (str.to_re (str.++ "t" (str.++ "j" "")))(re.union (str.to_re (str.++ "t" (str.++ "k" "")))(re.union (str.to_re (str.++ "t" (str.++ "l" "")))(re.union (str.to_re (str.++ "t" (str.++ "n" "")))(re.union (str.to_re (str.++ "t" (str.++ "o" "")))(re.union (str.to_re (str.++ "t" (str.++ "p" "")))(re.union (str.to_re (str.++ "t" (str.++ "r" "")))(re.union (str.to_re (str.++ "t" (str.++ "t" "")))(re.union (str.to_re (str.++ "t" (str.++ "v" "")))(re.union (str.to_re (str.++ "t" (str.++ "w" "")))(re.union (str.to_re (str.++ "t" (str.++ "z" "")))(re.union (str.to_re (str.++ "u" (str.++ "a" "")))(re.union (str.to_re (str.++ "u" (str.++ "g" "")))(re.union (str.to_re (str.++ "u" (str.++ "k" "")))(re.union (str.to_re (str.++ "u" (str.++ "m" "")))(re.union (str.to_re (str.++ "u" (str.++ "s" "")))(re.union (str.to_re (str.++ "u" (str.++ "y" "")))(re.union (str.to_re (str.++ "u" (str.++ "z" "")))(re.union (str.to_re (str.++ "v" (str.++ "a" "")))(re.union (str.to_re (str.++ "v" (str.++ "c" "")))(re.union (str.to_re (str.++ "v" (str.++ "e" "")))(re.union (str.to_re (str.++ "v" (str.++ "g" "")))(re.union (str.to_re (str.++ "v" (str.++ "i" "")))(re.union (str.to_re (str.++ "v" (str.++ "n" "")))(re.union (str.to_re (str.++ "v" (str.++ "u" "")))(re.union (str.to_re (str.++ "w" (str.++ "f" "")))(re.union (str.to_re (str.++ "w" (str.++ "s" "")))(re.union (str.to_re (str.++ "y" (str.++ "e" "")))(re.union (str.to_re (str.++ "y" (str.++ "t" "")))(re.union (str.to_re (str.++ "y" (str.++ "u" "")))(re.union (str.to_re (str.++ "z" (str.++ "a" "")))(re.union (str.to_re (str.++ "z" (str.++ "m" ""))) (str.to_re (str.++ "z" (str.++ "w" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))(re.++ (re.* (re.++ (re.range ":" ":") (re.+ (re.range "0" "9")))) (re.* (re.++ (re.range "/" "/") (re.+ (re.union (re.range "#" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
