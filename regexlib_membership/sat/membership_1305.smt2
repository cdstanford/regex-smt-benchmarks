;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\\(\\[\w-]+){1,}(\\[\w-()]+(\s[\w-()]+)*)+(\\(([\w-()]+(\s[\w-()]+)*)+\.[\w]+)?)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\\u00CF\u00AA\\u00F486\u00F1\u00F2\u00D5\\u00AA\"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xcf" (seq.++ "\xaa" (seq.++ "\x5c" (seq.++ "\xf4" (seq.++ "8" (seq.++ "6" (seq.++ "\xf1" (seq.++ "\xf2" (seq.++ "\xd5" (seq.++ "\x5c" (seq.++ "\xaa" (seq.++ "\x5c" "")))))))))))))))
;witness2: "\\H5\\u00F8\\u00CF\\u00E7\u00D2\\u00FC\"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "H" (seq.++ "5" (seq.++ "\x5c" (seq.++ "\xf8" (seq.++ "\x5c" (seq.++ "\xcf" (seq.++ "\x5c" (seq.++ "\xe7" (seq.++ "\xd2" (seq.++ "\x5c" (seq.++ "\xfc" (seq.++ "\x5c" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "\x5c" "\x5c")(re.++ (re.+ (re.++ (re.range "\x5c" "\x5c") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))(re.++ (re.+ (re.++ (re.range "\x5c" "\x5c")(re.++ (re.+ (re.union (re.range "(" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))) (re.* (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.+ (re.union (re.range "(" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))))(re.++ (re.opt (re.++ (re.range "\x5c" "\x5c") (re.opt (re.++ (re.+ (re.++ (re.+ (re.union (re.range "(" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))) (re.* (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.+ (re.union (re.range "(" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
