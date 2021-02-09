;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Nbr>[\+-]?((\d*\,\d+)|(\d*\.\d+)|\d+))\s*(?<Unit>mm|cm|dm|min|km|s|m|h)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+984089\u0085\u0085\xBcmo"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "\x0b" (seq.++ "c" (seq.++ "m" (seq.++ "o" ""))))))))))))))
;witness2: "\x2\u00BC+8.8559 \u00A0cm\u0081"
(define-fun Witness2 () String (seq.++ "\x02" (seq.++ "\xbc" (seq.++ "+" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "5" (seq.++ "5" (seq.++ "9" (seq.++ " " (seq.++ "\xa0" (seq.++ "c" (seq.++ "m" (seq.++ "\x81" "")))))))))))))))

(assert (= regexA (re.++ (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",") (re.+ (re.range "0" "9"))))(re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (re.+ (re.range "0" "9")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (str.to_re (seq.++ "m" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "c" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "d" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "m" (seq.++ "i" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "k" (seq.++ "m" ""))) (re.union (re.range "h" "h")(re.union (re.range "m" "m") (re.range "s" "s"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
