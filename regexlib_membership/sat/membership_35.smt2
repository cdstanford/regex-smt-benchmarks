;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{1,2}\.\d{1,2}\.\d{4})|(^\d{1,2}\.\d{1,2})|(^\d{1,2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9.89\u00BB"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "." (seq.++ "8" (seq.++ "9" (seq.++ "\xbb" ""))))))
;witness2: "21"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "1" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 4 4) (re.range "0" "9")))))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9"))))) (re.++ (re.++ (str.to_re "") ((_ re.loop 1 2) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
