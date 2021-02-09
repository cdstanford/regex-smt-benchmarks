;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?<r>([-+]?(\d+\.?\d*|\d*\.?\d+)([Ee][-+]?[0-2]?\d{1,2})?[r]?))|(?<i>([-+]?((\d+\.?\d*|\d*\.?\d+)([Ee][-+]?[0-2]?\d{1,2})?)?[i]))|(?<r>([-+]?(\d+\.?\d*|\d*\.?\d+)([Ee][-+]?[0-2]?\d{1,2})?[r]?))(?<i>([-+]((\d+\.?\d*|\d*\.?\d+)([Ee][-+]?[0-2]?\d{1,2})?)?[i])))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+953r"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "5" (seq.++ "3" (seq.++ "r" ""))))))
;witness2: "+9.3i"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "9" (seq.++ "." (seq.++ "3" (seq.++ "i" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.union (re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9")))) (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))) (re.opt (re.range "r" "r")))))(re.union (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.++ (re.union (re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9")))) (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9"))))) (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))))) (re.range "i" "i"))) (re.++ (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.union (re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9")))) (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))) (re.opt (re.range "r" "r"))))) (re.++ (re.union (re.range "+" "+") (re.range "-" "-"))(re.++ (re.opt (re.++ (re.union (re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9")))) (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9"))))) (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))))) (re.range "i" "i")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
