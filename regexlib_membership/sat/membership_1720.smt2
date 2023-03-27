;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "699."
(define-fun Witness1 () String (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "." "")))))
;witness2: "7488."
(define-fun Witness2 () String (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "." ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9")) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.* (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
