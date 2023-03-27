;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Nbr>[\+-]?((\d*\,\d+)|(\d*\.\d+)|\d+))\s*(?<Unit>mm|cm|dm|min|km|s|m|h)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+984089\u0085\u0085\xBcmo"
(define-fun Witness1 () String (str.++ "+" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{0b}" (str.++ "c" (str.++ "m" (str.++ "o" ""))))))))))))))
;witness2: "\x2\u00BC+8.8559 \u00A0cm\u0081"
(define-fun Witness2 () String (str.++ "\u{02}" (str.++ "\u{bc}" (str.++ "+" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "5" (str.++ "5" (str.++ "9" (str.++ " " (str.++ "\u{a0}" (str.++ "c" (str.++ "m" (str.++ "\u{81}" "")))))))))))))))

(assert (= regexA (re.++ (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",") (re.+ (re.range "0" "9"))))(re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (re.+ (re.range "0" "9")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (str.to_re (str.++ "m" (str.++ "m" "")))(re.union (str.to_re (str.++ "c" (str.++ "m" "")))(re.union (str.to_re (str.++ "d" (str.++ "m" "")))(re.union (str.to_re (str.++ "m" (str.++ "i" (str.++ "n" ""))))(re.union (str.to_re (str.++ "k" (str.++ "m" ""))) (re.union (re.range "h" "h")(re.union (re.range "m" "m") (re.range "s" "s"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
