;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 1?[ \.\-\+]?[(]?([0-9]{3})?[)]?[ \.\-\+]?[0-9]{3}[ \.\-\+]?[0-9]{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x151 (886) 878 8899"
(define-fun Witness1 () String (str.++ "\u{15}" (str.++ "1" (str.++ " " (str.++ "(" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ ")" (str.++ " " (str.++ "8" (str.++ "7" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" ""))))))))))))))))))
;witness2: "\xD\u0099\u00A01(158)+5947789\u00F8\x2"
(define-fun Witness2 () String (str.++ "\u{0d}" (str.++ "\u{99}" (str.++ "\u{a0}" (str.++ "1" (str.++ "(" (str.++ "1" (str.++ "5" (str.++ "8" (str.++ ")" (str.++ "+" (str.++ "5" (str.++ "9" (str.++ "4" (str.++ "7" (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "\u{f8}" (str.++ "\u{02}" ""))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" "."))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" "."))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" ".")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
