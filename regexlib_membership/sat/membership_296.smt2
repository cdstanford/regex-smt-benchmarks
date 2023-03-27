;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (".+"\s)?<?[a-z\._0-9]+[^\._]@([a-z0-9]+\.)+[a-z0-9]{2,6}>?;?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"\u00AD\" .\xD@u3q.8x>;"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "\u{ad}" (str.++ "\u{22}" (str.++ " " (str.++ "." (str.++ "\u{0d}" (str.++ "@" (str.++ "u" (str.++ "3" (str.++ "q" (str.++ "." (str.++ "8" (str.++ "x" (str.++ ">" (str.++ ";" ""))))))))))))))))
;witness2: "54\u00E9@k.a01\u00EA"
(define-fun Witness2 () String (str.++ "5" (str.++ "4" (str.++ "\u{e9}" (str.++ "@" (str.++ "k" (str.++ "." (str.++ "a" (str.++ "0" (str.++ "1" (str.++ "\u{ea}" "")))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "\u{22}" "\u{22}") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.opt (re.range "<" "<"))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "\u{00}" "-")(re.union (re.range "/" "^") (re.range "`" "\u{ff}")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "." ".")))(re.++ ((_ re.loop 2 6) (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.opt (re.range ">" ">")) (re.opt (re.range ";" ";"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
