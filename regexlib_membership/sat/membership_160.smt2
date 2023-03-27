;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{1}$|^[1-6]{1}[0-3]{1}$|^64$|\-[1-9]{1}$|^\-[1-6]{1}[0-3]{1}$|^\-64$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-63"
(define-fun Witness1 () String (str.++ "-" (str.++ "6" (str.++ "3" ""))))
;witness2: "-64"
(define-fun Witness2 () String (str.++ "-" (str.++ "6" (str.++ "4" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "0" "9") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "1" "6")(re.++ (re.range "0" "3") (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "6" (str.++ "4" ""))) (str.to_re "")))(re.union (re.++ (re.range "-" "-")(re.++ (re.range "1" "9") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "-" "-")(re.++ (re.range "1" "6")(re.++ (re.range "0" "3") (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "-" (str.++ "6" (str.++ "4" "")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
