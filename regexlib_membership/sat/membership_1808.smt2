;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([0-9]{1,3})|([a-zA-Z]{2,3})|(aero|coop|info|museum|name))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-.zz.99@z-.-.9"
(define-fun Witness1 () String (str.++ "-" (str.++ "." (str.++ "z" (str.++ "z" (str.++ "." (str.++ "9" (str.++ "9" (str.++ "@" (str.++ "z" (str.++ "-" (str.++ "." (str.++ "-" (str.++ "." (str.++ "9" "")))))))))))))))
;witness2: "b.U@Y.Vf.-.-.or-b.CRy2.9Kk.name"
(define-fun Witness2 () String (str.++ "b" (str.++ "." (str.++ "U" (str.++ "@" (str.++ "Y" (str.++ "." (str.++ "V" (str.++ "f" (str.++ "." (str.++ "-" (str.++ "." (str.++ "-" (str.++ "." (str.++ "o" (str.++ "r" (str.++ "-" (str.++ "b" (str.++ "." (str.++ "C" (str.++ "R" (str.++ "y" (str.++ "2" (str.++ "." (str.++ "9" (str.++ "K" (str.++ "k" (str.++ "." (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" ""))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 1 3) (re.range "0" "9"))(re.union ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.union (str.to_re (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" "")))))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" "")))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))(re.union (str.to_re (str.++ "m" (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "u" (str.++ "m" ""))))))) (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" ""))))))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
