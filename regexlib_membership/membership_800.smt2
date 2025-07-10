;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\s]*(?:(Public|Private)[\s]+(?:[_][\s]*[\n\r]+)?)?(Function|Sub)[\s]+(?:[_][\s]*[\n\r]+)?([a-zA-Z][\w]{0,254})(?:[\s\n\r_]*\((?:[\s\n\r_]*([a-zA-Z][\w]{0,254})[,]?[\s]*)*\))?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: " Private \u0085\xD\xD\u00A0Function \u00A0\xC\u00A0Y\u00E4"
(define-fun Witness1 () String (str.++ " " (str.++ "P" (str.++ "r" (str.++ "i" (str.++ "v" (str.++ "a" (str.++ "t" (str.++ "e" (str.++ " " (str.++ "\u{85}" (str.++ "\u{0d}" (str.++ "\u{0d}" (str.++ "\u{a0}" (str.++ "F" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{0c}" (str.++ "\u{a0}" (str.++ "Y" (str.++ "\u{e4}" ""))))))))))))))))))))))))))))
;witness2: "Private\u00A0_\xDFunction\u00A0E\u00F8\u00EC"
(define-fun Witness2 () String (str.++ "P" (str.++ "r" (str.++ "i" (str.++ "v" (str.++ "a" (str.++ "t" (str.++ "e" (str.++ "\u{a0}" (str.++ "_" (str.++ "\u{0d}" (str.++ "F" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "\u{a0}" (str.++ "E" (str.++ "\u{f8}" (str.++ "\u{ec}" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.++ (re.union (str.to_re (str.++ "P" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" ""))))))) (str.to_re (str.++ "P" (str.++ "r" (str.++ "i" (str.++ "v" (str.++ "a" (str.++ "t" (str.++ "e" "")))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.opt (re.++ (re.range "_" "_")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.+ (re.union (re.range "\u{0a}" "\u{0a}") (re.range "\u{0d}" "\u{0d}")))))))))(re.++ (re.union (str.to_re (str.++ "F" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" ""))))))))) (str.to_re (str.++ "S" (str.++ "u" (str.++ "b" "")))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.++ (re.range "_" "_")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.+ (re.union (re.range "\u{0a}" "\u{0a}") (re.range "\u{0d}" "\u{0d}"))))))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 0 254) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.opt (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "_" "_")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.range "(" "(")(re.++ (re.* (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "_" "_")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 0 254) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.opt (re.range "," ",")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))) (re.range ")" ")"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
