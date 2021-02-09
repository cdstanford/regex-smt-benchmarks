;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(1?(?: |\-|\.)?(?:\(\d{3}\)|\d{3})(?: |\-|\.)?\d{3}(?: |\-|\.)?\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1558997-9987"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "5" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "7" "")))))))))))))
;witness2: "1(896)9899998"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "(" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ ")" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range ")" ")"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "."))) ((_ re.loop 4 4) (re.range "0" "9")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
