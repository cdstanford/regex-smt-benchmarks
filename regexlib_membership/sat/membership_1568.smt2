;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\(?\d\d\d\)?)?( |-|\.)?\d\d\d( |-|\.)?\d{4,4}(( |-|\.)?[ext\.]+ ?\d+)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "189895.9988x... 0"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "x" (seq.++ "." (seq.++ "." (seq.++ "." (seq.++ " " (seq.++ "0" ""))))))))))))))))))
;witness2: "(928-5972418"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "-" (seq.++ "5" (seq.++ "9" (seq.++ "7" (seq.++ "2" (seq.++ "4" (seq.++ "1" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.opt (re.range ")" ")")))))))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "e" "e")(re.union (re.range "t" "t") (re.range "x" "x")))))(re.++ (re.opt (re.range " " " ")) (re.+ (re.range "0" "9")))))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
