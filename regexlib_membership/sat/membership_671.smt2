;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [-]?[1-9]\d{0,16}\.?\d{0,2}|[-]?[0]?\.[1-9]{1,2}|[-]?[0]?\.[0-9][1-9]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x427.18\u00D1\u00B4"
(define-fun Witness1 () String (seq.++ "\x04" (seq.++ "2" (seq.++ "7" (seq.++ "." (seq.++ "1" (seq.++ "8" (seq.++ "\xd1" (seq.++ "\xb4" "")))))))))
;witness2: "-0.03"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "0" (seq.++ "." (seq.++ "0" (seq.++ "3" ""))))))

(assert (= regexA (re.union (re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 16) (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) ((_ re.loop 0 2) (re.range "0" "9"))))))(re.union (re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "1" "9"))))) (re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9") (re.range "1" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
