;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\+?1[0-7]\d(\.\d+)?$)|(^\+?([1-9])?\d(\.\d+)?$)|(^-180$)|(^-1[1-7]\d(\.\d+)?$)|(^-[1-9]\d(\.\d+)?$)|(^\-\d(\.\d+)?$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+6.5"
(define-fun Witness1 () String (str.++ "+" (str.++ "6" (str.++ "." (str.++ "5" "")))))
;witness2: "168.849"
(define-fun Witness2 () String (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "4" (str.++ "9" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "1")(re.++ (re.range "0" "7")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (str.to_re "")))))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.opt (re.range "1" "9"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "-" (str.++ "1" (str.++ "8" (str.++ "0" ""))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "-" (str.++ "1" "")))(re.++ (re.range "1" "7")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.range "-" "-")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (re.range "-" "-")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
