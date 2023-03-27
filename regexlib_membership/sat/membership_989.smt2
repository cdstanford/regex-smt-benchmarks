;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<raw_message>\:(?<source>((?<nick>[^!]+)![~]{0,1}(?<user>[^@]+)@)?(?<host>[^\s]+)) (?<command>[^\s]+)( )?(?<parameters>[^:]+){0,1}(:)?(?<text>[^\r^\n]+)?)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ":\u00C0\u00F0\u00B7\u008F!~C@o\u00F4\u00ED\x16 \u00E0D\u0091\u00F7Y\u0090\u00B0di\u00FB\u00C2"
(define-fun Witness1 () String (str.++ ":" (str.++ "\u{c0}" (str.++ "\u{f0}" (str.++ "\u{b7}" (str.++ "\u{8f}" (str.++ "!" (str.++ "~" (str.++ "C" (str.++ "@" (str.++ "o" (str.++ "\u{f4}" (str.++ "\u{ed}" (str.++ "\u{16}" (str.++ " " (str.++ "\u{e0}" (str.++ "D" (str.++ "\u{91}" (str.++ "\u{f7}" (str.++ "Y" (str.++ "\u{90}" (str.++ "\u{b0}" (str.++ "d" (str.++ "i" (str.++ "\u{fb}" (str.++ "\u{c2}" ""))))))))))))))))))))))))))
;witness2: "$\u00D5\u00EF\u00E7\u00EAG:\x5\x14\u00C91\u00B6!~\u00EF@\x1B\u00BE\u00DB \u00C0\u00B3B\u00A1\u00D86h"
(define-fun Witness2 () String (str.++ "$" (str.++ "\u{d5}" (str.++ "\u{ef}" (str.++ "\u{e7}" (str.++ "\u{ea}" (str.++ "G" (str.++ ":" (str.++ "\u{05}" (str.++ "\u{14}" (str.++ "\u{c9}" (str.++ "1" (str.++ "\u{b6}" (str.++ "!" (str.++ "~" (str.++ "\u{ef}" (str.++ "@" (str.++ "\u{1b}" (str.++ "\u{be}" (str.++ "\u{db}" (str.++ " " (str.++ "\u{c0}" (str.++ "\u{b3}" (str.++ "B" (str.++ "\u{a1}" (str.++ "\u{d8}" (str.++ "6" (str.++ "h" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range ":" ":")(re.++ (re.++ (re.opt (re.++ (re.+ (re.union (re.range "\u{00}" " ") (re.range "\u{22}" "\u{ff}")))(re.++ (re.range "!" "!")(re.++ (re.opt (re.range "~" "~"))(re.++ (re.+ (re.union (re.range "\u{00}" "?") (re.range "A" "\u{ff}"))) (re.range "@" "@")))))) (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))(re.++ (re.range " " " ")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.+ (re.union (re.range "\u{00}" "9") (re.range ";" "\u{ff}"))))(re.++ (re.opt (re.range ":" ":")) (re.opt (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "]") (re.range "_" "\u{ff}")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
