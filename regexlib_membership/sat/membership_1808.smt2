;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([0-9]{1,3})|([a-zA-Z]{2,3})|(aero|coop|info|museum|name))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-.zz.99@z-.-.9"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "." (seq.++ "z" (seq.++ "z" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "@" (seq.++ "z" (seq.++ "-" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "9" "")))))))))))))))
;witness2: "b.U@Y.Vf.-.-.or-b.CRy2.9Kk.name"
(define-fun Witness2 () String (seq.++ "b" (seq.++ "." (seq.++ "U" (seq.++ "@" (seq.++ "Y" (seq.++ "." (seq.++ "V" (seq.++ "f" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "o" (seq.++ "r" (seq.++ "-" (seq.++ "b" (seq.++ "." (seq.++ "C" (seq.++ "R" (seq.++ "y" (seq.++ "2" (seq.++ "." (seq.++ "9" (seq.++ "K" (seq.++ "k" (seq.++ "." (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" ""))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 1 3) (re.range "0" "9"))(re.union ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.union (str.to_re (seq.++ "a" (seq.++ "e" (seq.++ "r" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "o" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "f" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "m" (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "u" (seq.++ "m" ""))))))) (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" ""))))))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
