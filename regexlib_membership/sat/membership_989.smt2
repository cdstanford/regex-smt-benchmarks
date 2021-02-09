;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<raw_message>\:(?<source>((?<nick>[^!]+)![~]{0,1}(?<user>[^@]+)@)?(?<host>[^\s]+)) (?<command>[^\s]+)( )?(?<parameters>[^:]+){0,1}(:)?(?<text>[^\r^\n]+)?)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ":\u00C0\u00F0\u00B7\u008F!~C@o\u00F4\u00ED\x16 \u00E0D\u0091\u00F7Y\u0090\u00B0di\u00FB\u00C2"
(define-fun Witness1 () String (seq.++ ":" (seq.++ "\xc0" (seq.++ "\xf0" (seq.++ "\xb7" (seq.++ "\x8f" (seq.++ "!" (seq.++ "~" (seq.++ "C" (seq.++ "@" (seq.++ "o" (seq.++ "\xf4" (seq.++ "\xed" (seq.++ "\x16" (seq.++ " " (seq.++ "\xe0" (seq.++ "D" (seq.++ "\x91" (seq.++ "\xf7" (seq.++ "Y" (seq.++ "\x90" (seq.++ "\xb0" (seq.++ "d" (seq.++ "i" (seq.++ "\xfb" (seq.++ "\xc2" ""))))))))))))))))))))))))))
;witness2: "$\u00D5\u00EF\u00E7\u00EAG:\x5\x14\u00C91\u00B6!~\u00EF@\x1B\u00BE\u00DB \u00C0\u00B3B\u00A1\u00D86h"
(define-fun Witness2 () String (seq.++ "$" (seq.++ "\xd5" (seq.++ "\xef" (seq.++ "\xe7" (seq.++ "\xea" (seq.++ "G" (seq.++ ":" (seq.++ "\x05" (seq.++ "\x14" (seq.++ "\xc9" (seq.++ "1" (seq.++ "\xb6" (seq.++ "!" (seq.++ "~" (seq.++ "\xef" (seq.++ "@" (seq.++ "\x1b" (seq.++ "\xbe" (seq.++ "\xdb" (seq.++ " " (seq.++ "\xc0" (seq.++ "\xb3" (seq.++ "B" (seq.++ "\xa1" (seq.++ "\xd8" (seq.++ "6" (seq.++ "h" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range ":" ":")(re.++ (re.++ (re.opt (re.++ (re.+ (re.union (re.range "\x00" " ") (re.range "\x22" "\xff")))(re.++ (re.range "!" "!")(re.++ (re.opt (re.range "~" "~"))(re.++ (re.+ (re.union (re.range "\x00" "?") (re.range "A" "\xff"))) (re.range "@" "@")))))) (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))(re.++ (re.range " " " ")(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.+ (re.union (re.range "\x00" "9") (re.range ";" "\xff"))))(re.++ (re.opt (re.range ":" ":")) (re.opt (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "]") (re.range "_" "\xff")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
