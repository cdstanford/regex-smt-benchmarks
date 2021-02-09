;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\s]*(?:(Public|Private)[\s]+(?:[_][\s]*[\n\r]+)?)?(Function|Sub)[\s]+(?:[_][\s]*[\n\r]+)?([a-zA-Z][\w]{0,254})(?:[\s\n\r_]*\((?:[\s\n\r_]*([a-zA-Z][\w]{0,254})[,]?[\s]*)*\))?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: " Private \u0085\xD\xD\u00A0Function \u00A0\xC\u00A0Y\u00E4"
(define-fun Witness1 () String (seq.++ " " (seq.++ "P" (seq.++ "r" (seq.++ "i" (seq.++ "v" (seq.++ "a" (seq.++ "t" (seq.++ "e" (seq.++ " " (seq.++ "\x85" (seq.++ "\x0d" (seq.++ "\x0d" (seq.++ "\xa0" (seq.++ "F" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ " " (seq.++ "\xa0" (seq.++ "\x0c" (seq.++ "\xa0" (seq.++ "Y" (seq.++ "\xe4" ""))))))))))))))))))))))))))))
;witness2: "Private\u00A0_\xDFunction\u00A0E\u00F8\u00EC"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "r" (seq.++ "i" (seq.++ "v" (seq.++ "a" (seq.++ "t" (seq.++ "e" (seq.++ "\xa0" (seq.++ "_" (seq.++ "\x0d" (seq.++ "F" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "\xa0" (seq.++ "E" (seq.++ "\xf8" (seq.++ "\xec" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.++ (re.union (str.to_re (seq.++ "P" (seq.++ "u" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "c" ""))))))) (str.to_re (seq.++ "P" (seq.++ "r" (seq.++ "i" (seq.++ "v" (seq.++ "a" (seq.++ "t" (seq.++ "e" "")))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.opt (re.++ (re.range "_" "_")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.+ (re.union (re.range "\x0a" "\x0a") (re.range "\x0d" "\x0d")))))))))(re.++ (re.union (str.to_re (seq.++ "F" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" ""))))))))) (str.to_re (seq.++ "S" (seq.++ "u" (seq.++ "b" "")))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.++ (re.range "_" "_")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.+ (re.union (re.range "\x0a" "\x0a") (re.range "\x0d" "\x0d"))))))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 0 254) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.opt (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "_" "_")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.range "(" "(")(re.++ (re.* (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "_" "_")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 0 254) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.opt (re.range "," ",")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))) (re.range ")" ")"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
