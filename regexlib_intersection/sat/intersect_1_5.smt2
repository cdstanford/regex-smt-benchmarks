;---
; using 8-bit bit-vectors as characters
; check intersection nonemptiness of .Net regexes
; regexA = ^\$?(\d{1,3},?(\d{3},?)*\d{3}(\.\d{0,2})?|\d{1,3}(\.\d{0,2})?|\.(\d{1,2})?)\z
; regexB = ^(\+|\-)?([0-9]*\.?[0-9]+|[0-9]+\.?[0-9]*)((e|E)(\+|\-)?[0-9]+)?\z
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const regexB RegLan)
(declare-const x String)

;witness: ".4"
(define-fun Witness () String (str.++ "." (str.++ "4" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.range "," ","))(re.++ (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "," ","))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9"))))))))(re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9"))))) (re.++ (re.range "." ".") (re.opt ((_ re.loop 1 2) (re.range "0" "9")))))) (str.to_re ""))))))

(assert (= regexB (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9")))) (re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9"))))) (str.to_re "")))))))

;check that the intersection is nonempty, contains some x
(assert (str.in_re x regexA))
(assert (str.in_re x regexB))
;check also the concrete witness
(assert (str.in_re Witness regexA))
(assert (str.in_re Witness regexB))
(check-sat)
