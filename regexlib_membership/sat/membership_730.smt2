;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[0][.]{1}[0-9]{0,}[1-9]+[0-9]{0,}$)|(^[1-9]+[0-9]{0,}[.]?[0-9]{0,}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "257."
(define-fun Witness1 () String (seq.++ "2" (seq.++ "5" (seq.++ "7" (seq.++ "." "")))))
;witness2: "481."
(define-fun Witness2 () String (seq.++ "4" (seq.++ "8" (seq.++ "1" (seq.++ "." "")))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "." "")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9")) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
