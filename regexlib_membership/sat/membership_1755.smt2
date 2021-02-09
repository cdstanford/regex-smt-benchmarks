;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9@*#]{8,15})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "F65F##XBV8*"
(define-fun Witness1 () String (seq.++ "F" (seq.++ "6" (seq.++ "5" (seq.++ "F" (seq.++ "#" (seq.++ "#" (seq.++ "X" (seq.++ "B" (seq.++ "V" (seq.++ "8" (seq.++ "*" ""))))))))))))
;witness2: "a*##*v8VO"
(define-fun Witness2 () String (seq.++ "a" (seq.++ "*" (seq.++ "#" (seq.++ "#" (seq.++ "*" (seq.++ "v" (seq.++ "8" (seq.++ "V" (seq.++ "O" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 15) (re.union (re.range "#" "#")(re.union (re.range "*" "*")(re.union (re.range "0" "9")(re.union (re.range "@" "Z") (re.range "a" "z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
