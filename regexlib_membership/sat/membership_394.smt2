;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(09|9)[1][1-9]\\d{7}$)|(^(09|9)[3][12456]\\d{7}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0913\ddddddd"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ "1" (seq.++ "3" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" "")))))))))))))
;witness2: "0931\ddddddd"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "9" (seq.++ "3" (seq.++ "1" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "9" ""))) (re.range "9" "9"))(re.++ (re.range "1" "1")(re.++ (re.range "1" "9")(re.++ (re.range "\x5c" "\x5c")(re.++ ((_ re.loop 7 7) (re.range "d" "d")) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "9" ""))) (re.range "9" "9"))(re.++ (re.range "3" "3")(re.++ (re.union (re.range "1" "2") (re.range "4" "6"))(re.++ (re.range "\x5c" "\x5c")(re.++ ((_ re.loop 7 7) (re.range "d" "d")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
