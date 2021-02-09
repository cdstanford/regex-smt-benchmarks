;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[[V|E|J|G]\d\d\d\d\d\d\d\d]{0,9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "|69289598]]"
(define-fun Witness1 () String (seq.++ "|" (seq.++ "6" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "]" (seq.++ "]" ""))))))))))))
;witness2: "|88563884]]"
(define-fun Witness2 () String (seq.++ "|" (seq.++ "8" (seq.++ "8" (seq.++ "5" (seq.++ "6" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "]" (seq.++ "]" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "E" "E")(re.union (re.range "G" "G")(re.union (re.range "J" "J")(re.union (re.range "V" "V")(re.union (re.range "[" "[") (re.range "|" "|"))))))(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ ((_ re.loop 0 9) (re.range "]" "]")) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
