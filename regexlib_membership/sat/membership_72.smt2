;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((([1]?\d)?\d|2[0-4]\d|25[0-5])\.){3}(([1]?\d)?\d|2[0-4]\d|25[0-5]))|([\da-fA-F]{1,4}(\:[\da-fA-F]{1,4}){7})|(([\da-fA-F]{1,4}:){0,5}::([\da-fA-F]{1,4}:){0,5}[\da-fA-F]{1,4})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "C:d99F:4A8:AA:::9cE8:28F"
(define-fun Witness1 () String (str.++ "C" (str.++ ":" (str.++ "d" (str.++ "9" (str.++ "9" (str.++ "F" (str.++ ":" (str.++ "4" (str.++ "A" (str.++ "8" (str.++ ":" (str.++ "A" (str.++ "A" (str.++ ":" (str.++ ":" (str.++ ":" (str.++ "9" (str.++ "c" (str.++ "E" (str.++ "8" (str.++ ":" (str.++ "2" (str.++ "8" (str.++ "F" "")))))))))))))))))))))))))
;witness2: " \u00A6[\u00F3\x16098:7fe7:2:A88:95A:9AB:0:8f\xA\x10\x1D\u009C\u0090"
(define-fun Witness2 () String (str.++ " " (str.++ "\u{a6}" (str.++ "[" (str.++ "\u{f3}" (str.++ "\u{16}" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ ":" (str.++ "7" (str.++ "f" (str.++ "e" (str.++ "7" (str.++ ":" (str.++ "2" (str.++ ":" (str.++ "A" (str.++ "8" (str.++ "8" (str.++ ":" (str.++ "9" (str.++ "5" (str.++ "A" (str.++ ":" (str.++ "9" (str.++ "A" (str.++ "B" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "8" (str.++ "f" (str.++ "\u{0a}" (str.++ "\u{10}" (str.++ "\u{1d}" (str.++ "\u{9c}" (str.++ "\u{90}" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.opt (re.++ (re.opt (re.range "1" "1")) (re.range "0" "9"))) (re.range "0" "9"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))) (re.range "." "."))) (re.union (re.++ (re.opt (re.++ (re.opt (re.range "1" "1")) (re.range "0" "9"))) (re.range "0" "9"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))))(re.union (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) ((_ re.loop 7 7) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.++ (re.++ ((_ re.loop 0 5) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":")))(re.++ (str.to_re (str.++ ":" (str.++ ":" "")))(re.++ ((_ re.loop 0 5) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
