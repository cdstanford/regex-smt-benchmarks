;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = function[\s]+[\S]+[\s]*([\s]*)[\s]*{[\s]*([\S]|[\s])*[\s]*}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ufunction\x9\u00AB\xC {\x9}\x16\u009D"
(define-fun Witness1 () String (seq.++ "u" (seq.++ "f" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "\x09" (seq.++ "\xab" (seq.++ "\x0c" (seq.++ " " (seq.++ "{" (seq.++ "\x09" (seq.++ "}" (seq.++ "\x16" (seq.++ "\x9d" "")))))))))))))))))))
;witness2: "function\u00A0\x4\xA{ \u00B6}\u00AE"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "\xa0" (seq.++ "\x04" (seq.++ "\x0a" (seq.++ "{" (seq.++ " " (seq.++ "\xb6" (seq.++ "}" (seq.++ "\xae" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "f" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" "")))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "{" "{")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.* (re.range "\x00" "\xff"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "}" "}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
