;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Telephone>([0-9]|[ ]|[-]|[\(]|[\)]|ext.|[,])+)([ ]|[:]|\t|[-])*(?<Where>Home|Office|Work|Away|Fax|FAX|Phone)|(?<Where>Home|Office|Work|Away|Fax|FAX|Phone|Daytime|Evening)([ ]|[:]|\t|[-])*(?<Telephone>([0-9]|[ ]|[-]|[\(]|[\)]|ext.|[,])+)|(?<Telephone>([(]([0-9]){3}[)]([ ])?([0-9]){3}([ ]|-)([0-9]){4}))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Eveningext\u00B8extVext\x1ext\u00A8extR\u0095t"
(define-fun Witness1 () String (str.++ "E" (str.++ "v" (str.++ "e" (str.++ "n" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "\u{b8}" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "V" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "\u{01}" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "\u{a8}" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "R" (str.++ "\u{95}" (str.++ "t" ""))))))))))))))))))))))))))))))
;witness2: "82+\Fax:\x9ext\u00D366\u00DD\u00E0"
(define-fun Witness2 () String (str.++ "8" (str.++ "2" (str.++ "+" (str.++ "\u{5c}" (str.++ "F" (str.++ "a" (str.++ "x" (str.++ ":" (str.++ "\u{09}" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "\u{d3}" (str.++ "6" (str.++ "6" (str.++ "\u{dd}" (str.++ "\u{e0}" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (re.+ (re.union (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" "-") (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "e" (str.++ "x" (str.++ "t" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.range "," ","))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{09}")(re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range ":" ":"))))) (re.union (str.to_re (str.++ "H" (str.++ "o" (str.++ "m" (str.++ "e" "")))))(re.union (str.to_re (str.++ "O" (str.++ "f" (str.++ "f" (str.++ "i" (str.++ "c" (str.++ "e" "")))))))(re.union (str.to_re (str.++ "W" (str.++ "o" (str.++ "r" (str.++ "k" "")))))(re.union (str.to_re (str.++ "A" (str.++ "w" (str.++ "a" (str.++ "y" "")))))(re.union (str.to_re (str.++ "F" (str.++ "a" (str.++ "x" ""))))(re.union (str.to_re (str.++ "F" (str.++ "A" (str.++ "X" "")))) (str.to_re (str.++ "P" (str.++ "h" (str.++ "o" (str.++ "n" (str.++ "e" ""))))))))))))))(re.union (re.++ (re.union (str.to_re (str.++ "H" (str.++ "o" (str.++ "m" (str.++ "e" "")))))(re.union (str.to_re (str.++ "O" (str.++ "f" (str.++ "f" (str.++ "i" (str.++ "c" (str.++ "e" "")))))))(re.union (str.to_re (str.++ "W" (str.++ "o" (str.++ "r" (str.++ "k" "")))))(re.union (str.to_re (str.++ "A" (str.++ "w" (str.++ "a" (str.++ "y" "")))))(re.union (str.to_re (str.++ "F" (str.++ "a" (str.++ "x" ""))))(re.union (str.to_re (str.++ "F" (str.++ "A" (str.++ "X" ""))))(re.union (str.to_re (str.++ "P" (str.++ "h" (str.++ "o" (str.++ "n" (str.++ "e" ""))))))(re.union (str.to_re (str.++ "D" (str.++ "a" (str.++ "y" (str.++ "t" (str.++ "i" (str.++ "m" (str.++ "e" "")))))))) (str.to_re (str.++ "E" (str.++ "v" (str.++ "e" (str.++ "n" (str.++ "i" (str.++ "n" (str.++ "g" ""))))))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{09}")(re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range ":" ":"))))) (re.+ (re.union (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" "-") (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "e" (str.++ "x" (str.++ "t" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.range "," ",")))))) (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
