;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[^&gt;]*\n?.*=(&quot;|')?(.*\.jpg)(&quot;|')?.*\n?[^&lt;]*&gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0095\u00CB\u00E1&lt;\xA\u008D=.jpg&quot;&gt;n"
(define-fun Witness1 () String (seq.++ "\x95" (seq.++ "\xcb" (seq.++ "\xe1" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "\x0a" (seq.++ "\x8d" (seq.++ "=" (seq.++ "." (seq.++ "j" (seq.++ "p" (seq.++ "g" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "n" ""))))))))))))))))))))))))))
;witness2: "&lt;\x19\u00D1\u00B7\u009C\u00D1=.jpg\'f\u0097\u00D0&gt;t"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "\x19" (seq.++ "\xd1" (seq.++ "\xb7" (seq.++ "\x9c" (seq.++ "\xd1" (seq.++ "=" (seq.++ "." (seq.++ "j" (seq.++ "p" (seq.++ "g" (seq.++ "'" (seq.++ "f" (seq.++ "\x97" (seq.++ "\xd0" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "t" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff"))))))(re.++ (re.opt (re.range "\x0a" "\x0a"))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "=" "=")(re.++ (re.opt (re.union (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))) (re.range "'" "'")))(re.++ (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re (seq.++ "." (seq.++ "j" (seq.++ "p" (seq.++ "g" ""))))))(re.++ (re.opt (re.union (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))) (re.range "'" "'")))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.opt (re.range "\x0a" "\x0a"))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "k")(re.union (re.range "m" "s") (re.range "u" "\xff")))))) (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
