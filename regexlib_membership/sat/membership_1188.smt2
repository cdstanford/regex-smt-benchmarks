;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[+]?\d*\.?\d*[1-9]+\d*$)|(^[+]?[1-9]+\d*\.\d*$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+491318799838588"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "3" (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "8" "")))))))))))))))))
;witness2: "+22858987.88"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "2" (seq.++ "2" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "7" (seq.++ "." (seq.++ "8" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9")) (str.to_re "")))))))) (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.* (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
