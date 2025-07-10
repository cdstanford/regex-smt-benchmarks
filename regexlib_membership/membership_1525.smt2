;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = src[^&gt;]*[^/].(?:jpg|bmp|gif)(?:\&quot;|\')
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "src\x3\"gif&quot;H"
(define-fun Witness1 () String (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "\u{03}" (str.++ "\u{22}" (str.++ "g" (str.++ "i" (str.++ "f" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "H" ""))))))))))))))))
;witness2: "/srca\u00C1bmp&quot;"
(define-fun Witness2 () String (str.++ "/" (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "a" (str.++ "\u{c1}" (str.++ "b" (str.++ "m" (str.++ "p" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "s" (str.++ "r" (str.++ "c" ""))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}"))))))(re.++ (re.union (re.range "\u{00}" ".") (re.range "0" "\u{ff}"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.union (str.to_re (str.++ "j" (str.++ "p" (str.++ "g" ""))))(re.union (str.to_re (str.++ "b" (str.++ "m" (str.++ "p" "")))) (str.to_re (str.++ "g" (str.++ "i" (str.++ "f" "")))))) (re.union (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))) (re.range "'" "'")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
