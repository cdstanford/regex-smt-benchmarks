;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}[0-9]{3})|([A-Z]{2}[\ ][0-9]{3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ZK682\u00A9@"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "K" (seq.++ "6" (seq.++ "8" (seq.++ "2" (seq.++ "\xa9" (seq.++ "@" ""))))))))
;witness2: "_8GE 819"
(define-fun Witness2 () String (seq.++ "_" (seq.++ "8" (seq.++ "G" (seq.++ "E" (seq.++ " " (seq.++ "8" (seq.++ "1" (seq.++ "9" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 2 2) (re.range "A" "Z")) ((_ re.loop 3 3) (re.range "0" "9")))) (re.++ (re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.range " " " ") ((_ re.loop 3 3) (re.range "0" "9")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
