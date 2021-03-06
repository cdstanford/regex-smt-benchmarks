;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{5}\-\d{3}$)|(^\d{2}\.\d{3}\-\d{3}$)|(^\d{8}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "23094-981"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "3" (seq.++ "0" (seq.++ "9" (seq.++ "4" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "1" ""))))))))))
;witness2: "79899895"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "5" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
