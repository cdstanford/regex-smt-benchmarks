;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = src[^&gt;]*[^/].(?:jpg|bmp|gif)(?:\&quot;|\')
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "src\x3\"gif&quot;H"
(define-fun Witness1 () String (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "\x03" (seq.++ "\x22" (seq.++ "g" (seq.++ "i" (seq.++ "f" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "H" ""))))))))))))))))
;witness2: "/srca\u00C1bmp&quot;"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "a" (seq.++ "\xc1" (seq.++ "b" (seq.++ "m" (seq.++ "p" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "s" (seq.++ "r" (seq.++ "c" ""))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff"))))))(re.++ (re.union (re.range "\x00" ".") (re.range "0" "\xff"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "b" (seq.++ "m" (seq.++ "p" "")))) (str.to_re (seq.++ "g" (seq.++ "i" (seq.++ "f" "")))))) (re.union (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))) (re.range "'" "'")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
