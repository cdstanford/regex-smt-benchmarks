;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{3,4}\-\d{4}$)|(^\d{7,8}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2691513"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "6" (seq.++ "9" (seq.++ "1" (seq.++ "5" (seq.++ "1" (seq.++ "3" ""))))))))
;witness2: "2868943"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "3" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 7 8) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
