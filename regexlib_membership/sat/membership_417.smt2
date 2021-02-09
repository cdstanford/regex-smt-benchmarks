;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.pdf)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\E3\\u00BA\u00F8Gpdf"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "E" (seq.++ "3" (seq.++ "\x5c" (seq.++ "\xba" (seq.++ "\xf8" (seq.++ "G" (seq.++ "p" (seq.++ "d" (seq.++ "f" ""))))))))))))
;witness2: "\\\u00AA9$\\u00BA\u00B5prpdf"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xaa" (seq.++ "9" (seq.++ "$" (seq.++ "\x5c" (seq.++ "\xba" (seq.++ "\xb5" (seq.++ "p" (seq.++ "r" (seq.++ "p" (seq.++ "d" (seq.++ "f" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (re.++ ((_ re.loop 2 2) (re.range "\x5c" "\x5c")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.opt (re.range "$" "$"))))(re.++ (re.+ (re.++ (re.range "\x5c" "\x5c") (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))(re.++ (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "p" (seq.++ "d" (seq.++ "f" ""))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
