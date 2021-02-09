;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((0)+(\.[1-9](\d)?))|((0)+(\.(\d)[1-9]+))|(([1-9]+(0)?)+(\.\d+)?)|(([1-9]+(0)?)+(\.\d+)?)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0.12389929"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "." (seq.++ "1" (seq.++ "2" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "9" "")))))))))))
;witness2: "9.7"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "." (seq.++ "7" ""))))

(assert (= regexA (re.union (re.++ (re.+ (re.range "0" "0")) (re.++ (re.range "." ".")(re.++ (re.range "1" "9") (re.opt (re.range "0" "9")))))(re.union (re.++ (re.+ (re.range "0" "0")) (re.++ (re.range "." ".")(re.++ (re.range "0" "9") (re.+ (re.range "1" "9")))))(re.union (re.++ (re.+ (re.++ (re.+ (re.range "1" "9")) (re.opt (re.range "0" "0")))) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))) (re.++ (re.+ (re.++ (re.+ (re.range "1" "9")) (re.opt (re.range "0" "0")))) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
