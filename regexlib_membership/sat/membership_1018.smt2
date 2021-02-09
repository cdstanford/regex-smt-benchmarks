;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(IE){0,1}[0-9][0-9A-Z\+\*][0-9]{5}[A-Z]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9980319O"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "3" (seq.++ "1" (seq.++ "9" (seq.++ "O" "")))))))))
;witness2: "IE6+99974J"
(define-fun Witness2 () String (seq.++ "I" (seq.++ "E" (seq.++ "6" (seq.++ "+" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "4" (seq.++ "J" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "I" (seq.++ "E" ""))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "*" "+")(re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "A" "Z") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
