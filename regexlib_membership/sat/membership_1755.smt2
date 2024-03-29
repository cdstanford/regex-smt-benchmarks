;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9@*#]{8,15})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "F65F##XBV8*"
(define-fun Witness1 () String (str.++ "F" (str.++ "6" (str.++ "5" (str.++ "F" (str.++ "#" (str.++ "#" (str.++ "X" (str.++ "B" (str.++ "V" (str.++ "8" (str.++ "*" ""))))))))))))
;witness2: "a*##*v8VO"
(define-fun Witness2 () String (str.++ "a" (str.++ "*" (str.++ "#" (str.++ "#" (str.++ "*" (str.++ "v" (str.++ "8" (str.++ "V" (str.++ "O" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 15) (re.union (re.range "#" "#")(re.union (re.range "*" "*")(re.union (re.range "0" "9")(re.union (re.range "@" "Z") (re.range "a" "z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
