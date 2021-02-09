;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+|-)?(\d\.\d{1,6}|[1-8]\d\.\d{1,6}|90\.0{1,6})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1.9806"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "6" "")))))))
;witness2: "-90.0"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "9" (seq.++ "0" (seq.++ "." (seq.++ "0" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.union (re.++ (re.range "0" "9")(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "8")(re.++ (re.range "0" "9")(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))) (re.++ (str.to_re (seq.++ "9" (seq.++ "0" (seq.++ "." "")))) ((_ re.loop 1 6) (re.range "0" "0"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
