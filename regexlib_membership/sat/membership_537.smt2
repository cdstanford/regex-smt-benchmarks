;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 1?[ \.\-\+]?[(]?([0-9]{3})?[)]?[ \.\-\+]?[0-9]{3}[ \.\-\+]?[0-9]{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x151 (886) 878 8899"
(define-fun Witness1 () String (seq.++ "\x15" (seq.++ "1" (seq.++ " " (seq.++ "(" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ ")" (seq.++ " " (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" ""))))))))))))))))))
;witness2: "\xD\u0099\u00A01(158)+5947789\u00F8\x2"
(define-fun Witness2 () String (seq.++ "\x0d" (seq.++ "\x99" (seq.++ "\xa0" (seq.++ "1" (seq.++ "(" (seq.++ "1" (seq.++ "5" (seq.++ "8" (seq.++ ")" (seq.++ "+" (seq.++ "5" (seq.++ "9" (seq.++ "4" (seq.++ "7" (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "\xf8" (seq.++ "\x02" ""))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" "."))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" "."))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" ".")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
