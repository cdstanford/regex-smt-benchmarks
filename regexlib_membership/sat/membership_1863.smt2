;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\(?\+?[0-9]*\)?)?[0-9_\- \(\)]*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+"
(define-fun Witness1 () String (str.++ "+" ""))
;witness2: "(+)"
(define-fun Witness2 () String (str.++ "(" (str.++ "+" (str.++ ")" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ (re.opt (re.range "+" "+"))(re.++ (re.* (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "_" "_")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
