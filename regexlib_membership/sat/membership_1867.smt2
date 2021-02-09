;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{6}[\s\-]{1}[0-9]{12}|[0-9]{18})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "228798 512989699985"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "2" (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "5" (seq.++ "1" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "5" ""))))))))))))))))))))
;witness2: "882899\u00A0899809598620"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "\xa0" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "2" (seq.++ "0" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 12 12) (re.range "0" "9")))) ((_ re.loop 18 18) (re.range "0" "9"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
