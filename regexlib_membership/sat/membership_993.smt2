;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?:[+\-]?\$?)|(?:\$?[+\-]?))?(?:(?:\d{1,3}(?:(?:,\d{3})|(?:\d))*(?:\.(?:\d*|\d+[eE][+\-]\d+))?)|(?:\.\d+(?:[eE][+\-]\d+)?))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "939."
(define-fun Witness1 () String (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "." "")))))
;witness2: ".87E+98"
(define-fun Witness2 () String (seq.++ "." (seq.++ "8" (seq.++ "7" (seq.++ "E" (seq.++ "+" (seq.++ "9" (seq.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.opt (re.range "$" "$"))) (re.++ (re.opt (re.range "$" "$")) (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))))))(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))) (re.range "0" "9"))) (re.opt (re.++ (re.range "." ".") (re.union (re.* (re.range "0" "9")) (re.++ (re.+ (re.range "0" "9"))(re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.+ (re.range "0" "9")))))))))) (re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9")) (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.+ (re.range "0" "9")))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
